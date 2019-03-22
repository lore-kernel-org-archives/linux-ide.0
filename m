From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Date: Fri, 22 Mar 2019 17:36:43 +0000
Message-ID: <20190322173643.75a81d1b@alans-desktop>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
        <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
        <20190312104102.GA28302@Red>
        <20190312120623.46ca7286@alans-desktop>
        <20190312133808.GA9336@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312133808.GA9336@Red>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe@baylibre.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, axboe@kernel.dk, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > If the virtual Sparc emulator is using it does that also mean actual
> > Sparc hardware has it. In which case presumably it needs fixing, or at
> > least moving to the generic driver assuming the firmware sets it up ?
> >   
> 
> The qemu works perfectly with the new Linux driver.

For some configurations both drivers will work with even older chips. The
question is whether your chip has separate slave timings, if not then
while it'll work single device with ata_piix some combinations will fail.

Digging into the datasheet the part in question has slave timing (0x44) so
should indeed be ata_piix.

Alan
