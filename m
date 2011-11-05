From: Junio C Hamano <junio@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Sat, 05 Nov 2011 16:49:15 -0700
Message-ID: <7vsjm2870k.fsf@alter.siamese.dyndns.org>
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
 <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
 <7v1utn9it8.fsf@alter.siamese.dyndns.org>
 <CA+55aFy0gA0ROSyE03h6Lw0zn4B4j-oEFBmffOcWs6NfyYy8JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFy0gA0ROSyE03h6Lw0zn4B4j-oEFBmffOcWs6NfyYy8JA@mail.gmail.com> (Linus
 Torvalds's message of "Sat, 5 Nov 2011 09:41:25 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ted Ts'o <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I'd really like some way to not see it.
>
> Ted suggested a NUL character in the commit message in front of the
> "hidden content". What do you think?

You do not have to resort to NUL; we could just stuff whatever you do not
need to see but needs to be left *intact* in the new header fields just
like the embedded GPG signatures are stored in signed commits.

By the time the integrator is presented the merge commit template, we
would have:

 1. The merge title (e.g. "Merge tag for-linus of git://.../rusty.git/");

 2. Payload of the signed tag (or just "annotated tag"), which is used to
    convey meaningful topic description from the lieutenant;

 3. The signature in the tag, if the tag is not just merely annotated, but
    is signed;

 4. The output from GPG verification of the above (only when 3. is
    available); and

 5. The traditional "merge summary", if merge.log is enabled.

The 10-patch series I sent earlier appends 2 and 3 with "tag:" prefix and
4 with "# " prefix in the commit log template, but it does not have to be
that way. We could arrange things so that we put only 1, 2, 4 (still with
"# " prefix because this is meant to help you verify the authenticity, not
for later third-party audit, and to be stripped away with stripspace
before the commit is made) and 5 in the commit log template, and the
original signed tag contents (only when the tag is signed, not merely
annotated) in a separate file MERGE_SIG in $GIT_DIR/ next to MERGE_MSG,
and teach "git commit" to pick it up and stuff it in a new header field.

That way, the integrator can use the message 2 for the commit log message
and is free to typofix it, without breaking later third-party audit which
would use what is taken literally from the signed tag and stored in the
new header field, because the integrator's editor would never touch the
latter.
