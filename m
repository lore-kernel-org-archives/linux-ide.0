From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 1/4] scsi: introduce sync_before_stop flag
Date: Mon, 24 Sep 2012 18:13:19 -0400
Message-ID: <5060DAFF.60904@pobox.com>
References: <1347951631-1592-1-git-send-email-aaron.lu@intel.com> <1347951631-1592-2-git-send-email-aaron.lu@intel.com> <1347955015.2388.0.camel@dabdike.int.hansenpartnership.com> <20120918080915.GA1740@mint-spring.sh.intel.com> <1347956420.2388.9.camel@dabdike.int.hansenpartnership.com> <20120918083138.GA1792@mint-spring.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56652 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab2IXWNX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2012 18:13:23 -0400
In-Reply-To: <20120918083138.GA1792@mint-spring.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, Aaron Lu <aaron.lwe@gmail.com>, Jack Wang <jack_wang@usish.com>, Shane Huang <shane.huang@amd.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org

On 09/18/2012 04:31 AM, Aaron Lu wrote:
> I agree that it is better handled in libata's SALT, I tried to do this
> but didn't find a good way so I introduced this flag. The SALT is 1-1
> mapping, I'm not sure how to handle this 1-2 mapping.

That is the crux of the matter:  it is rather difficult within the 
current code, if there is not a 1:1 correspondence between SCSI command 
and ATA command.

The solution that works within libata-scsi.c involves creating two 
ata_queued_cmd's, and managing the issuance and completion yourself.

But really -- the most practical route seems to be simply to set WCE, to 
trigger the desired behavior.

	Jeff



