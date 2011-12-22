From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patch] libata build fix for 3.2-rc
Date: Thu, 22 Dec 2011 14:09:00 -0800
Message-ID: <7vk45ocl8j.fsf@alter.siamese.dyndns.org>
References: <20111222202017.GA13208@havoc.gtf.org>
 <CA+55aFycz+kScx671vQaLyHz6jyQUJ_ZB6MYx1scdHjX29R_0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFycz+kScx671vQaLyHz6jyQUJ_ZB6MYx1scdHjX29R_0Q@mail.gmail.com> (Linus
 Torvalds's message of "Thu, 22 Dec 2011 12:59:14 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Dec 22, 2011 at 12:20 PM, Jeff Garzik <jeff@garzik.org> wrote:
>>
>> A sparc build fix...
>
> Pulled..
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>
> And these days it would actually be better if you just use git signed
> tags instead, and ask me to pull them. You don't need to do anything
> special per se (just "git tag -s" to create the signature, and then
> "git push -tags" to push it out), it's only the merger who has to then
> have a recent enough git version that pulling the tag will DTRT. And I
> do.

"git push --tags" may be a bit too much. A lieutenant can just push that
signed tag being requested to get pulled and nothing else. And after the
integrator responds to the request, the signed tag can be removed from the
publishing repository of the requestor to keep namespace clean and neat.

> See
>   https://lkml.org/lkml/2011/12/14/543
>
> that I sent to Ted about how it ends up looking - you can check out
> that commit 2240a7bb479c with "git show" and "git cat-file commit" to
> see how your signature would be archived and saved without actually
> being bothersome when just looking at the history.

This falls into a shameless plug category, but at http://goo.gl/3OImV
there is my write-up on the whole workflow.

We would need to add some Porcelain support for third-party (as opposed to
the integrator who is resonding to the pull request and verifies the
signed tag himself) auditors, by the way.
