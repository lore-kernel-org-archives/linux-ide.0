From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: [PATCH 3/5] ata: Add TRIM infrastructure
Date: Thu, 2 Apr 2009 09:47:42 -0700
Message-ID: <20090402164742.GP2661@linux.intel.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <49D4DFFB.8070201@ru.mvista.com> <20090402161835.GN2661@linux.intel.com> <49D4E8B8.5000301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:8026 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932258AbZDBQro (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 12:47:44 -0400
Content-Disposition: inline
In-Reply-To: <49D4E8B8.5000301@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

On Thu, Apr 02, 2009 at 08:32:56PM +0400, Sergei Shtylyov wrote:
> Matthew Wilcox wrote:
>
>>>   I wonder where to read about the word 169 and commnand 0x06... 
>>> what's it all about?
>
>> It's in d2015r1-ATAATAPI_Command_Set_-_2_ACS-2.pdf which can be found on
>> the t13 website.
>
>    But since neither ATA/PI-7 nor ATA/PI-8 mention neither the word nor  
> command, why your validity check requires only ATA/PI-7+ compliance?

Because there are ATA-7 devices which implement this feature.
