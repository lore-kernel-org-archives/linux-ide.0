From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 20:12:51 +0100
Message-ID: <200901192012.51422.bzolnier@gmail.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain> <4974CA81.1050506@ru.mvista.com> <20090119184951.35a52184@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757429AbZASTNQ@vger.kernel.org>
In-Reply-To: <20090119184951.35a52184@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 19 January 2009, Alan Cox wrote:
> >     Tried looking at how in*()/out*() are defined on x86?
> 
> Tried looking at how ide_mm_inb is defined on x86
> 
> > > It's already making function calls, without the benefit of inlining and
> > 
> >     I'm afraid you're wrong here.
> 
> I'm afraid you are the one who is wrong. The IDE layer is duplicating a
> generic level of indirection with its own code - purely because IDE
> pre-dates that core functionality. The whole IDE layer indirection can go
> away because Linux has caught up with the needs of the IDE layer.

I wish it would be so simple as I would have removed the said indirection
long time ago.  Unfortunately:

- not all archs support ioread() & co.

- there is still issue with cache aliasing on some CPUs

Once above deficiences get fixed we can look into ioread() conversion again.

[ IOW right now it is the correct thing to stick to ide_mm_*() indirection
  since extra hardware coverage is more valuable than minor code cleanup. ]

Thanks,
Bart
