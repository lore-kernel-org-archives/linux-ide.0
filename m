From: Jeff Garzik <jgarzik@pobox.com>
Subject: [try2] [PATCH] Silicon Image SATA 3124 driver preview
Date: Fri, 13 May 2005 15:20:23 -0400
Message-ID: <4284FDF7.9020608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262517AbVEMTZP@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Carlos Pardo <Carlos.Pardo@siliconimage.com>
List-Id: linux-ide@vger.kernel.org


My previous posting of this driver appears to be have disappeared into
the ether.  Let's see if this gets through.


Silicon Image recently contributed a PREVIEW RELEASE (for review, not
production use) driver for their new 3124 series of cards.

The SiI 3124 cards, much like the AHCI hardware now appearing, is
among the first of the SATA cards to use a highly efficient command
delivery method, the FIS.  Rather than emulate an ATA shadow register
set, FIS-based SATA controllers expose on-the-wire SATA FISs to the
OS driver.  FIS-based SATA controllers tend to be more efficient,
and less error prone, than non-FIS-based controllers.


Download URL:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.12-rc2-sil24-1.patch.bz2

[email servers seem to have eaten the email that contained the sil24 
driver in an inline patch]


My own review comments on this driver:

1) basically OK

2) I would prefer that bus reset be better integrated into libata core,
rather than moving most of the operations into sata_sil24 driver.  I'm
trying to keep SATA PHY access as common as possible, across the many
pieces of SATA hardware out there.  It remains to be seen, how possible
is this goal?...

3) When Port Multiplier support is enabled, it will need to be integrated
into libata core, so that all controllers can support it.  Some
controllers will have "hardware assist" for PM, and others not.  We'll
have to handle both.

4) Long delay in sil_wait_for_completion().  Long delays should be
converted into a sleep, or performed in some other method other than
busy-wait.

5) [style] Linux kernel code style avoids what we call StudlyCaps, which
is the C++ way of separating words.  Linux prefers "fis_type" to
"FisType", and "port_registers" or "port_regs" to "Port_Registers".

6) This driver does not appear to support 64-bit?

+       writel((u32) paddr, &port_base->CmdActivate[0].s.ActiveLow);

We definitely do not want to add any 32-bit assumptions into a new Linux
driver.

7) [bug] the following is unacceptably long, in issue_soft_reset:
+       udelay(10000); /* delay 10 ms */

8) [bug] ditto, in sil_init_pm()

9) your struct Port_Registers likely need the 'packed' gcc attribute
