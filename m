From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] libata: improve ATA ACPI support
Date: Sun, 22 Apr 2007 19:25:00 +0100
Message-ID: <20070422192500.2e1014fd@the-village.bc.nu>
References: <11772636651400-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> * after successfully executing _GTF taskfiles, IDENTIFY page is
>   reloaded

Interesting question we should sort out: What is our identify page as
supplied to the user meant to be ?

The old IDE one started off as the "identify data at boot" (which is
useful) and mutated through a million "kind of boot but mangled" and "not
boot" versions of the identify data, all of which are useless to
userspace.

Having the "boot" data (for some definition of boot) is important in
order to know things like the BIOS view of the disk geometry and HPA (eg
for partitioning), having the current data is useless as its already
available via SG_IO.

Alan
