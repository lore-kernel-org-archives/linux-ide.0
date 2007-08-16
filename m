From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core: support wildcard matching in ata_blacklist_entry
Date: Thu, 16 Aug 2007 15:07:07 -0400
Message-ID: <46C4A05B.4000007@garzik.org>
References: <20070808202057.GA23314@dhcp-210.hsv.redhat.com> <20070809003134.12de8576@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51234 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179AbXHPTHK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 15:07:10 -0400
In-Reply-To: <20070809003134.12de8576@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Wed, 8 Aug 2007 15:20:57 -0500
> David Milburn <dmilburn@redhat.com> wrote:
> 
>> Support the use of '*' in model_num and model_rev entries
>> in ata_device_blacklist[].
>>
>> CC: alan@lxorguk.ukuu.org.uk
>> Signed-off-by: David Milburn <dmilburn@redhat.com>
> 
> Suggestion: Pull the match function out of line so you don't have two
> copies of it and can remove all the wacky ? operators
> 
> something like this ? (untested)
> 
> 	strpatterncmp(const char *name, const char *patt)
> 	{
> 		const char *p = strchr(patt, '*');
> 		if (p == NULL)
> 			p = patt + strlen(patt);
> 		return strncmp(name, patt, p-patt);
> 	}

Seems quite sane to me...

And I support the addition of wildcard operators; that should make 
maintenance a bit easier.


