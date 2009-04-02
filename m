From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/5] ata: Add TRIM infrastructure
Date: Thu, 02 Apr 2009 20:32:56 +0400
Message-ID: <49D4E8B8.5000301@ru.mvista.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <49D4DFFB.8070201@ru.mvista.com> <20090402161835.GN2661@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10081 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752337AbZDBQc0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 12:32:26 -0400
In-Reply-To: <20090402161835.GN2661@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

Matthew Wilcox wrote:

>>   I wonder where to read about the word 169 and commnand 0x06... what's 
>>it all about?

> It's in d2015r1-ATAATAPI_Command_Set_-_2_ACS-2.pdf which can be found on
> the t13 website.

    But since neither ATA/PI-7 nor ATA/PI-8 mention neither the word nor 
command, why your validity check requires only ATA/PI-7+ compliance?

MBR, Sergei
