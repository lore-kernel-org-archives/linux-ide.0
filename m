From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Another Maxtor drive with broken NCQ
Date: Fri, 06 Jul 2007 15:13:45 -0400
Message-ID: <468E9469.4090007@redhat.com>
References: <468E8DE1.9010405@redhat.com> <468E9360.4070504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48145 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968AbXGFTNs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Jul 2007 15:13:48 -0400
In-Reply-To: <468E9360.4070504@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 07/06/2007 03:09 PM, Jeff Garzik wrote:
>>
>> {"Maxtor 6B200M0",      "BANC1BM0",     ATA_HORKAGE_NONCQ }
>>
>> Or should *all* Maxtor 6B200M0 be blacklisted, since there's already
>> one of them in the list?
> 
> Wanna send that as a patch, with attribution and sign-offs?  :)
> 

For all revisions, or just that one new one?
