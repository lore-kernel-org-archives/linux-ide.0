From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: problem detecting ATAPI device with ahci on 2.6.21-rcx
Date: Thu, 29 Mar 2007 11:06:20 -0700
Message-ID: <20070329110620.7bbc105f.kristen.c.accardi@intel.com>
References: <20070320164920.0bad5c42.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030574AbXC2SIv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Mar 2007 14:08:51 -0400
In-Reply-To: <20070320164920.0bad5c42.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org, rol@as2917.net, htejun@gmail.com

On Tue, 20 Mar 2007 16:49:20 -0700
Kristen Carlson Accardi <kristen.c.accardi@intel.com> wrote:

> Hi, I upgrade a machine from 2.6.20->2.6.21-rc4 and am now having problems
> with my ATAPI device getting detected properly.  Back tracking to 2.6.21-rc1,
> I find the problem existed there too, but not in 2.6.20.

Hi, just letting you know that I tried 2.6.21-rc5 and the problem has 
disappeared, so whatever it was is fixed now.  

Thanks,
Kristen
