From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 2/2] ahci: only attach ICH6-M if it's in SATA mode
Date: Mon, 16 Dec 2013 21:28:12 +0100
Message-ID: <1387225692.14970.13.camel@x41.thuisdomein>
References: <1387190097.9255.31.camel@x41.thuisdomein>
	 <20131216155136.GF32509@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131216155136.GF32509@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 2013-12-16 at 10:51 -0500, Tejun Heo wrote:
> I'm not quite sure about this one.  The patch seems correct on the
> surface but given how old ich6 is at this point, the general
> crappiness of BIOS on ahci front in that era, and that the existing
> code has been working fine for all these years make me very reluctant
> to change it.  e.g. I don't think CLASS_STORAGE_SATA was the only one.
> They used different class for raid too.

Well, raid should only be relevant for ICH6R (which has its own device
ID). The datasheet I've been staring at suggests that ICH6-M is
hardwired to either use PCI_CLASS_STORAGE_SATA or PCI_CLASS_STORAGE_IDE.

> It should be able to figure
> out things given enough test cases but I don't think we have that
> anymore and the benefit (avoding probe failure messages) doesn't seem
> to justify the risk.

That's your call, obviously. And I don't think that hardware like this
is used widely to run release candidates, if at all, so we can't even
consider a see-who-screams-when-their-setup-breaks approach.

Thanks,


Paul Bolle
