From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] ahci: EM supported message type sysfs attribute
Date: Fri, 4 Mar 2011 10:39:56 -0800
Message-ID: <20110304103956.7360a840@kcaccard-MOBL3>
References: <20110304085452.83B5EF90E1@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22693 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759729Ab1CDShw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2011 13:37:52 -0500
In-Reply-To: <20110304085452.83B5EF90E1@ochil.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, 04 Mar 2011 09:54:52 +0100
hare@suse.de (Hannes Reinecke) wrote:

> 
> This patch adds an sysfs attribute 'em_message_supported' to the
> ahci host device which prints out the supported enclosure management
> message types.

Is it useful to display the host controllers supported em
message types when libata only can support LED type?
