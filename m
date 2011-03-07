From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] ahci: EM supported message type sysfs attribute
Date: Mon, 7 Mar 2011 09:32:12 -0800
Message-ID: <20110307093212.67ec383a@kcaccard-MOBL3>
References: <20110304085452.83B5EF90E1@ochil.suse.de>
	<20110304103956.7360a840@kcaccard-MOBL3>
	<4D74FE92.3040201@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37574 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041Ab1CGRbd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2011 12:31:33 -0500
In-Reply-To: <4D74FE92.3040201@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 07 Mar 2011 16:49:38 +0100
Hannes Reinecke <hare@suse.de> wrote:

> Incidentally, if you know of a chipset/board already supporting
> different message types I'm all ears :-)

Sorry, I haven't looked at EMS since I added this feature for ICH9,
and then all we had was LED.  There may very well be chipsets out
there that support more types, who knows.
