From: Christophe Saout <christophe@saout.de>
Subject: Re: CPRM ?? Re: Possibly wrong BIO usage in ide_multwrite
Date: Fri, 02 Jan 2004 13:45:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1073047522.4239.6.camel@leto.cs.pocnet.net>
References: <Pine.LNX.4.10.10401012018030.32122-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10401012018030.32122-100000@master.linux-ide.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Am Fr, den 02.01.2004 schrieb Andre Hedrick um 05:43:

> I am sorry but adding in a splitter to CPRM is not acceptable.
> Digital Rights Management in the kernel is not acceptable to me, period.
> 
> Maybe I have misread your intent and the contents on your website.
>
> Device-Mappers are one thing, intercepting buffers in the taskfile FSM
> transport is another.  This stinks of CPRM at this level, regardless of
> your intent.  Do correct me if I am wrong.

I can assure you I was never having DRM or anything like this in mind
nor making fundamental changes to the IDE layer. It was just that
++bi_idx that bugged me. Must be a misunderstanding, sorry. :)

The only thing I'm having on my website is a device-mapper target that
does basically the same as cryptoloop tries to. It's just about
encrypting sensitive data on top of any other device, nothing else.
