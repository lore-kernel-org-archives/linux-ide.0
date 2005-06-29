From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: siimage card causes repeated oopses and panics on a PowerMac G4 running 2.6.12.1
Date: Wed, 29 Jun 2005 12:12:10 +0200
Message-ID: <58cb370e050629031277d13798@mail.gmail.com>
References: <9c1484f205062702203936d7ca@mail.gmail.com>
	 <42BFE177.1050007@pobox.com>
	 <6A4A6C03-7A2D-45BE-AE66-4CF38F8607EC@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.197]:44356 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262497AbVF2KMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Jun 2005 06:12:12 -0400
Received: by nproxy.gmail.com with SMTP id o25so269566nfa
        for <linux-ide@vger.kernel.org>; Wed, 29 Jun 2005 03:12:10 -0700 (PDT)
In-Reply-To: <6A4A6C03-7A2D-45BE-AE66-4CF38F8607EC@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Schlansker <stevenschlansker@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hi,

On 6/28/05, Steven Schlansker <stevenschlansker@gmail.com> wrote:
> I turned off preempt and compiled the sata_sil driver.  Loading it
> did not seem to cause any troubles, but dmesg had nothing but a
> version message.  No discovery of hardware seemed to happen with the
> sata driver (this is not a sata card as far as I know?) and no /dev/
> sd? or /dev/hd? entries appeared at all.

Yep, SiI680 is a PATA chipset, sata_sil won't help.

> The old kernel module, recompiled without preempt, still causes
> crashing and general badness.
> 
> Thank you for the suggestions, got anything else to try?

Disabling PMAC IDE driver - actual OOPS comes from it (weird).

Please also send full dmesg output.

Bartlomiej
