ALL_src_VFILES := src/Base.v src/Hoare.v src/Impl_base.v src/Inhabited.v src/Instances.v src/Instr_kinds.v src/MachineWord.v src/MachineWordInterface.v src/Operators_mwords.v src/Prompt.v src/Prompt_monad.v src/Real.v src/State.v src/State_lemmas.v src/State_lifting.v src/State_monad.v src/State_monad_lemmas.v src/String.v src/TypeCasts.v src/Undefined.v src/Values.v src/Values_lemmas.v

ALL_src-stdpp_VFILES := src-stdpp/Base.v src-stdpp/ConcurrencyInterface.v src-stdpp/ConcurrencyInterfaceTypes.v src-stdpp/ConcurrencyInterfaceBuiltins.v src-stdpp/ConcurrencyInterfaceV2.v src-stdpp/ConcurrencyInterfaceTypesV2.v src-stdpp/ConcurrencyInterfaceBuiltinsV2.v src-stdpp/Hoare.v src-stdpp/Impl_base.v src-stdpp/Inhabited.v src-stdpp/Instances.v src-stdpp/Instr_kinds.v src-stdpp/MachineWord.v src-stdpp/MachineWordTest.v src-stdpp/MachineWordInterface.v src-stdpp/Operators_mwords.v src-stdpp/Prompt.v src-stdpp/Prompt_monad.v src-stdpp/Real.v src-stdpp/State.v src-stdpp/State_lemmas.v src-stdpp/State_lifting.v src-stdpp/State_monad.v src-stdpp/State_monad_lemmas.v src-stdpp/String.v src-stdpp/TypeCasts.v src-stdpp/Undefined.v src-stdpp/Values.v src-stdpp/Values_lemmas.v

src:
	rocq makefile -Q $@ Sail -o Makefile.coq $(ALL_src_VFILES)
	echo "-Q $@ Sail" > _RocqProject
	$(MAKE) -f Makefile.coq

src-stdpp:
	rocq makefile -Q $@ Sail -o Makefile.coq $(ALL_src-stdpp_VFILES)
	echo "-Q $@ Sail" > _RocqProject
	$(MAKE) -f Makefile.coq

clean::
	if [ -e Makefile.coq ]; then $(MAKE) -f Makefile.coq cleanall; fi
	$(RM) $(wildcard Makefile.coq Makefile.coq.conf) 

-include Makefile.coq

.PHONY: src src-stdpp clean
