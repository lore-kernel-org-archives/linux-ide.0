From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata_piix: add PCI IDs for Intel BayTail
Date: Thu, 30 May 2013 16:03:23 +0900
Message-ID: <20130530070323.GD22604@mtj.dyndns.org>
References: <1368689609-26864-1-git-send-email-chiauee85@gmail.com>
 <20130516180728.GC7171@mtj.dyndns.org>
 <20130516181857.GD7171@mtj.dyndns.org>
 <CAA9G2fWUZy3-QDMjGm2vZkZfoyvKiQO-kM3-6jHNUiQ62tHXVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39769 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967671Ab3E3HD2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 May 2013 03:03:28 -0400
Content-Disposition: inline
In-Reply-To: <CAA9G2fWUZy3-QDMjGm2vZkZfoyvKiQO-kM3-6jHNUiQ62tHXVA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: chew chiau ee <chiauee85@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Chew Chiau Ee <chiau.ee.chew@intel.com>

On Thu, May 30, 2013 at 03:02:41PM +0800, chew chiau ee wrote:
> Baytrail supports only two SATA ports.
> Baytrail is using the mapping table of ich8_2port_map_db  while SNB is
> using mapping table of  ich8_map_db.

Ah, alright.  Thanks for the explanation. :)

-- 
tejun
