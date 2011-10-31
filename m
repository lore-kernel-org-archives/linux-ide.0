From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 16:09:09 -0700
Message-ID: <7vlis0oj1m.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
 <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com>
 <CA+55aFzedaAzzWfzhqVf8y8ZW0jeb56hZwdV3UodSp8Q_Qhc2A@mail.gmail.com>
 <7vvcr4ojvp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7vvcr4ojvp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 31 Oct 2011 15:51:06 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> ...
> As I already said, I do not think notes is a good match as a tool to do
> this.
>
>> matters is that "git push" and "git pull" would JustWork(tm), and
>> check the signature if one exists, without having to cut-and-paste
>> data that simply shouldn't be visible to the user.
>>
>> I abhor the interface Ingo suggested, for example....
>
> Some cut-and-paste (or piping the e-mail to a command) would be necessary
> evil, though, as you would have GPG keys from more than one trusted person
> in your keyring, and when you are responding to a pull-request from person
> A, finding a valid commit signed by person B should not be a success, but
> at least should raise a warning.

So here is a quick hack that does not involve cut-and-paste (it depends on
the signed-commit topic in 'next').

 $ git pull --require-signature

would trigger signature verification and stops you after fetching but
before merging.

 git-pull.sh |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 9868a0b..f3b4c93 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -39,7 +39,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity= progress= recurse_submodules=
+log_arg= verbosity= progress= recurse_submodules= must_be_signed=
 merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
@@ -60,6 +60,8 @@ do
 		diffstat=--no-stat ;;
 	--stat|--summary)
 		diffstat=--stat ;;
+	--require-signature)
+		must_be_signed=yes ;;
 	--log|--no-log)
 		log_arg=$1 ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
@@ -208,6 +210,27 @@ orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
 
+if test -n "$must_be_signed"
+then
+	signature=$(git show -s --format='%G?' FETCH_HEAD)
+	case "$signature" in
+	G)
+		case "$verbosity" in
+		*' '-v*)
+			git show -s --show-signature FETCH_HEAD ;;
+		esac
+		;;
+	B)
+		echo >&2 "Bad signature on the tip commit"
+		exit 1
+		;;
+	*)
+		echo >&2 "Tip commit must be signed"
+		exit 1
+		;;
+	fi
+fi
+
 curr_head=$(git rev-parse -q --verify HEAD)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
 then
