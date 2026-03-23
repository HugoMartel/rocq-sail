ALL_src_VFILES := src/Base.v src/Hoare.v src/Impl_base.v src/Inhabited.v src/Instances.v src/Instr_kinds.v src/MachineWord.v src/MachineWordInterface.v src/Operators_mwords.v src/Prompt.v src/Prompt_monad.v src/Real.v src/State.v src/State_lemmas.v src/State_lifting.v src/State_monad.v src/State_monad_lemmas.v src/String.v src/TypeCasts.v src/Undefined.v src/Values.v src/Values_lemmas.v

ALL_src-stdpp_VFILES :=

src:
	rocq makefile -Q $@ Sail -o Makefile.coq $(ALL_src_VFILES)
	$(MAKE) -f Makefile.coq

src-stdpp:
	rocq makefile -Q $@ Sail -o Makefile.coq $(ALL_src-stdpp_VFILES)
	$(MAKE) -f Makefile.coq

clean::
	if [ -e Makefile.coq ]; then $(MAKE) -f Makefile.coq cleanall; fi
	$(RM) $(wildcard Makefile.coq Makefile.coq.conf) 

-include Makefile.coq

.PHONY: src src-stdpp clean
