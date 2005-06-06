From: Mark Lord <liml@rtr.ca>
Subject: Re: [SATA] libata-dev queue updated
Date: Mon, 06 Jun 2005 12:01:58 -0400
Message-ID: <42A47376.80203@rtr.ca>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261209AbVFFQCZ@vger.kernel.org>
In-Reply-To: <87vf4ujgmj.fsf@stark.xeocode.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, James Bottomley <James.Bottomley@steeleye.com>
List-Id: linux-ide@vger.kernel.org

Greg Stark wrote:
>
> Are there diffs downloadable for these? In particular I'm looking for
> passthru. I'm imagining that with passthru SMART works?

SMART works already using the HDIO_* ioctls in libata-dev
(these may be built on top of the passthru stuff.. dunno).

Eg.  smartctl -data -a /dev/sda

Cheers
