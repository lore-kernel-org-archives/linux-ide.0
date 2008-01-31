From: Mark Lord <liml@rtr.ca>
Subject: Re: Add one more HITACHI SATA disk to NCQ blacklist
Date: Thu, 31 Jan 2008 12:23:56 -0500
Message-ID: <47A2042C.2070703@rtr.ca>
References: <1201797194.7165.13.camel@user-computer> <47A203B4.8020902@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4351 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761334AbYAaRX5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jan 2008 12:23:57 -0500
In-Reply-To: <47A203B4.8020902@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simos Xenitellis <simos.lists@googlemail.com>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Simos Xenitellis wrote:
>> Hi,
>> The hard disk with     model num: "HITACHI HTS541616J9SA00"
>>     model rev: "SB4IC7UP"
>>
>> is causing NCQ errors and should be blacklisted.
..
>> https://bugs.edge.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/137470 
>>
> ..
> 
> That one is for 2.6.22.  We need to know if the problem exists with 2.6.24,
> as the NCQ code has had a number of fixes since July 2007.
..

Answering my own question here:  if one actually reads through the thread
linked to above, it says that the 2.6.24 kernel seems to have resolved all issues.
..
>> Could you please add the entry
>>     { "HITACHI HTS541616J9SA00",    NULL,     ATA_HORKAGE_NONCQ, },
..

There doesn't appear to be any reason to do this, unless you have more information ?
