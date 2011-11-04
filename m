From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 04 Nov 2011 14:12:36 -0700
Message-ID: <7vaa8bbni3.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7v62j1gitn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Nov 2011 11:16:37 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ted Ts'o <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>>   [torvalds@i5 linux]$ git fetch
>> git://github.com/rustyrussell/linux.git
>> rusty@rustcorp.com.au-v3.1-8068-g5087a50
>>   fatal: Couldn't find remote ref rusty@rustcorp.com.au-v3.1-8068-g5087a50
>>
>> oops. Ok, so his tag naming is *really* akward. Whatever.
>
> It is not "Whatever".
>
>  $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v3.0
>  fatal: Couldn't find remote ref v3.0
>
> I do not think we ever DWIMmed fetch refspecs to prefix refs/tags/, so it
> is not the naming but fetching tags without saying "git fetch tag v3.0"
> (which IIRC was your invention long time ago). 

If we really wanted to go this route, the attached single-liner should be
sufficient for the DWIMmery.

Note that the DWIMmery rules for "git fetch" and local "git rev-parse" are
still different even after this patch.

"git log frotz" can DWIM to "refs/remotes/frotz/HEAD", but in the remote
access context, "git fetch frotz" to fetch what the other side happened to
have fetched from what it calls 'frotz' (which may not have any relation
to what we consider is 'frotz') the last time would not make much sense,
so the fetch rules table does not include "refs/remotes/%.*s/HEAD".

When the user really wants to, "git fetch $there remotes/frotz/HEAD" would
let her do so anyway, so this is not about safety or security; it merely
is about confusion avoidance and discouraging meaningless usage.

Specifically, it is _not_ about ambiguity avoidance. A name that would
become ambiguous if we use the same rules table for both fetch and local
rev-parse would be ambiguous locally at the remote side.

If we really wanted to, we could 

	#define ref_fetch_rules ref_rev_parse_rules
 
in cache.h and remove the array's declaration from cache.h and its
definition from refs.c to really unify the two, but I haven't thought
things through.

-- >8 --
Subject: [PATCH] fetch: allow "git fetch $there v1.0" to fetch a tag

You can already do so with "git fetch $there tags/v1.0" but if it is not
ambiguous there is no reason to force users to type more.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index e69ba26..670a7b3 100644
--- a/refs.c
+++ b/refs.c
@@ -1001,6 +1001,7 @@ const char *ref_rev_parse_rules[] = {
 const char *ref_fetch_rules[] = {
 	"%.*s",
 	"refs/%.*s",
+	"refs/tags/%.*s",
 	"refs/heads/%.*s",
 	NULL
 };
-- 
1.7.8.rc0.108.g71b5ec
