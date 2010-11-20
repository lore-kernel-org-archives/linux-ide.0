From: Borislav Petkov <bp@alien8.de>
Subject: Re: ide boot failure 2.6.36/2.6.28 - 2.6.27 works
Date: Sat, 20 Nov 2010 08:45:08 +0100
Message-ID: <20101120074508.GA16854@liondog.tnic>
References: <20101120032828.GA14693@iq>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101120032828.GA14693@iq>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Nov 20, 2010 at 04:28:33AM +0100, Andries E. Brouwer wrote:
> Answering myself (and providing info that can be Googled):
> 
> > I wanted to boot a recent kernel on an old machine and failed.
> > The last kernel that worked was 2.6.27.
> > What goes wrong is that the disks are no longer detected on 2.6.28.
> 
> A typical error would be
> 
> 	Cannot open root device 342 or unknown block (3,66)
> 
> Reading the code shows that the default probing is no longer done.

Well, this got changed in 20df429dd6671804999493baf2952f82582869fa since
we had other problems when having ide-generic and a specific PCI IDE
controller driver enabled at the same time, AFAIR.

There are two fixes I can think of - you either enable the specific IDE
controller driver for your chipset or you enforce probing with

	ide_generic.probe_mask=0x3f

on the kernel command line.

HTH.

-- 
Regards/Gruss,
    Boris.
