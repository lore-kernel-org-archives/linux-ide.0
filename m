From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 45/86] pata_legacy: do not probe extra ports
 automatically if PCI is not present
Date: Wed, 25 Nov 2009 18:12:05 +0000
Message-ID: <20091125181205.24c2c97f@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170740.5446.67217.sendpatchset@localhost>
	<20091125173215.539b5630@lxorguk.ukuu.org.uk>
	<200911251845.52700.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934923AbZKYSKE@vger.kernel.org>
In-Reply-To: <200911251845.52700.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > NAK. You made a rather peculiar set of changes in the IDE layer but the
> 
> Please give commit numbers and describe such 'peculiar set of changes in
> the IDE layer' in more details or skip such baseless, unjust and pointless

Disabling what can be a safe probe

> comments from your mails.

The old IDE code didn't do the full PCI check that libata did at the time
there were public complaints. Libata legacy also doesn't fall for the bug
where legacy loads and blocks PCI adapters as it has a smart check in it,
including for weirdness like the CS55x0 and the MPIIX.

So I'm firmly of the opinion that
- We should leave it as is
- If it causes a problem we should look at the exact case involved.
  Possibly it would need a CONFIG_X86 but thats sort of implied as
  embedded use pata_platform in preference.

The fact it just works by default is very very important.
