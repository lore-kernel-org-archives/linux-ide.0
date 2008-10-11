From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: libata: set queue SSD flag for SSD devices
Date: Sat, 11 Oct 2008 09:04:07 -0700
Message-ID: <20081011090407.6de9b8b4@infradead.org>
References: <200810101904.m9AJ42Gq018897@hera.kernel.org>
	<20081010202515.446857cc@lxorguk.ukuu.org.uk>
	<20081010200528.GJ19428@kernel.dk>
	<20081010175508.3d1ed2a4@infradead.org>
	<1223710417.4159.11.camel@localhost.localdomain>
	<20081011140600.GR19428@kernel.dk>
	<1223739853.4159.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757876AbYJKQEa@vger.kernel.org>
In-Reply-To: <1223739853.4159.17.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, torvalds@osdl.org
List-Id: linux-ide@vger.kernel.org

On Sat, 11 Oct 2008 17:44:13 +0200
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> 
> > So we need something a bit more involved, but not too complex. A
> > fine line...
> 
> It's a policy ... just let userspace do it so the user can tune it.
> That's what EMC does now (except I think they key of inquiry strings
> rather than cache size).


while the chosen elevator obviously is policy, the kernel really should
pick a sensible default based on what it knows.
Lets put it this way: if userland needs to do a tuning to the kernel
based on data only provided by the kernel, and will always do it the
same way, we should have made that choice the default policy in the
kernel in the first place.

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
