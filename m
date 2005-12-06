From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Tue, 06 Dec 2005 22:50:43 +0000
Message-ID: <1133909443.26777.6.camel@localhost.localdomain>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965039AbVLFWwW@vger.kernel.org>
In-Reply-To: <20051206222001.GA14171@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-12-06 at 22:20 +0000, Matthew Garrett wrote:
> stuff doesn't seem terribly important. The reason for it not currently 
> being implemented is that the IDE queues haven't been restarted at the 
> point where this code is called, so there's no obvious way of submitting 
> them to the drive yet.

Issue the task files in sequence to the drive directly with nIEN set and
poll them. In the libata case there is a clean API to do this but even
the old IDE has enough order and logic in this area it would not be hard
to do nicely.
