From: Gabor Gombas <gombasg@sztaki.hu>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Mon, 4 Aug 2008 16:28:32 +0200
Message-ID: <20080804142831.GW8749@boogie.lpds.sztaki.hu>
References: <87prp1kvyy.fsf@denkblock.local> <20080726062142.29070.10413.stgit@denkblock.local> <4892B8FE.1070400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755603AbYHDO2o@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4892B8FE.1070400@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Aug 01, 2008 at 04:19:26PM +0900, Tejun Heo wrote:

> However, SATA or not, there simply isn't a way to abort commands in ATA.
>  Issuing random command while other commands are in progress simply is
> state machine violation and there will be many interesting results
> including complete system lockup (ATA controller dying while holding the
> PCI bus).

A system lockup may be an acceptable compromise if that saves the
hardware. Maybe the kernel should explicitely panic unless the
controller/drive is known to be able to recover.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
