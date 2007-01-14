From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.20-rc4-mm1
Date: Sun, 14 Jan 2007 23:31:41 +0100
Message-ID: <1168813901.2941.85.camel@localhost.localdomain>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	 <1168768104.2941.53.camel@localhost.localdomain>
	 <1168771617.2941.59.camel@localhost.localdomain>
	 <1168785616.2941.67.camel@localhost.localdomain>
	 <20070114220515.GG5860@kernel.dk>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751263AbXANWZf@vger.kernel.org>
In-Reply-To: <20070114220515.GG5860@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 2007-01-15 at 09:05 +1100, Jens Axboe wrote:
> raid seems to have severe problems with the plugging change. I'll try
> and find Neil and have a chat with him, hopefully we can work it out.

Some hints:

mount(1899): WRITE block 16424 on md3
call md_write_start
md3_raid1(438): WRITE block 40965504 on sdb6
md3_raid1(438): WRITE block 40965504 on sda6
First Write sector 16424 disks 2

Stuck.

Note, that neither end_buffer_async_write() nor
raid1_end_write_request() are invoked, 

In a previous write invoked by:
fsck.ext3(1896): WRITE block 8552 on sdb1
end_buffer_async_write() is invoked.

sdb1 is not a part of a raid device.

Hope that helps,

	tglx
