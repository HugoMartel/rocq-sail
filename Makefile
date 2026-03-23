COQMFFLAGS := -Q src Sail

# ALLVFILES := Base.v Hoare.v Impl_base.v Inhabited.v Instances.v Instr_kinds.v MachineWord.v MachineWordInterface.v Operators_mwords.v Prompt.v Prompt_monad.v Real.v State.v State_lemmas.v State_lifting.v State_monad.v State_monad_lemmas.v String.v TypeCasts.v Undefined.v Values.v Values_lemmas.v

ALLVFILES := src/Base.v src/Hoare.v src/Impl_base.v src/Inhabited.v src/Instances.v src/Instr_kinds.v src/MachineWord.v src/MachineWordInterface.v src/Operators_mwords.v src/Prompt.v src/Prompt_monad.v src/Real.v src/State.v src/State_lemmas.v src/State_lifting.v src/State_monad.v src/State_monad_lemmas.v src/String.v src/TypeCasts.v src/Undefined.v src/Values.v src/Values_lemmas.v


build: Makefile.coq
	$(MAKE) -f Makefile.coq

clean::
	if [ -e Makefile.coq ]; then $(MAKE) -f Makefile.coq cleanall; fi
	$(RM) $(wildcard Makefile.coq Makefile.coq.conf) 

Makefile.coq:
	rocq makefile $(COQMFFLAGS) -o Makefile.coq $(ALLVFILES)

-include Makefile.coq

.PHONY: build clean
