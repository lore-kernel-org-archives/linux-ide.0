From: Jarek Poplawski <jarkao2@o2.pl>
Subject: Re: [PATCH] sata_via: fix resource-managed iomap conversion
Date: Thu, 15 Feb 2007 12:29:05 +0100
Message-ID: <20070215112905.GA2347@ff.dom.local>
References: <45D0C9A0.1030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965657AbXBOLZy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45D0C9A0.1030707@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 12-02-2007 21:10, Tejun Heo wrote:
> Markus Trippelsdorf wrote:
>> On Mon, Feb 12, 2007 at 10:51:44AM -0800, Tejun Heo wrote:
>>> Conversion to resource-managed iomap was buggy causing init failures
>>> on both vt6420 and 6421 - BAR5 wasn't mapped for both controllers
>>> while on vt6420 sata_via tried to map BAR0-4 twice.  Fix it.
> 
> Great, can anyone verify this on vt6421?

I'm sure they will.

I can only confirm with vt6420 too and presume it
can't be worse, so please apply.

Thanks & regards,
Jarek P.
