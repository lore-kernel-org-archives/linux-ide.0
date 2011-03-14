From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata problem...
Date: Mon, 14 Mar 2011 15:22:13 -0400
Message-ID: <4D7E6AE5.7080709@teksavvy.com>
References: <04BB68BD-352B-45B0-A7FC-42B6005A80B3@freemail.hu> <20110227153338.GA23527@mtj.dyndns.org> <E0ABD6B5-3B05-48D8-AFDC-9FD559AF2583@freemail.hu> <4D7C27AB.1010908@gmail.com> <20110313084236.GH2005@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:29800 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755325Ab1CNTWS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 15:22:18 -0400
In-Reply-To: <20110313084236.GH2005@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Peter <elekesp@freemail.hu>, linux-ide@vger.kernel.org

On 11-03-13 04:42 AM, Tejun Heo wrote:
> On Sat, Mar 12, 2011 at 08:10:51PM -0600, Robert Hancock wrote:
>>> I dont know why there is "[    2.098493] ata4.00: failed command: READ FPDMA QUEUED" in dmesg.
>>>
>>> I have 3 WD Green 1TB HDD, and I samsung 160GB HDD.
>>> 1 SAMSUNG and 1 WD on the intel SATA,
>>> 2 WD on the GIGABYTE Sata.
>>> I think the problem is only with the gigabye sata port.
>>
>> That's an uncorrectable read error the drive is reporting. Most
>> likely that hard drive is failing.
> 
> Or maybe just a bad sector, in which case just writing it over would
> cause the drive to reallocate the failed region.  I think this
> partial/transient failure mode is much more common than the whole
> drive going south.


One would think so!  :)

But in my experience, the latter just about always follows the former
within a surprisingly short amount of time (weeks).

Cheers
