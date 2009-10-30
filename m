From: Peter Klotz <peter.klotz@aon.at>
Subject: Re: Errors when powering on eSATA box
Date: Fri, 30 Oct 2009 23:06:23 +0100
Message-ID: <4AEB635F.50404@aon.at>
References: <4AE9FDE6.5040203@aon.at> <4AEA2C54.9040502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from WARSL404PIP2.highway.telekom.at ([195.3.96.113]:18818 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932139AbZJ3WGV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Oct 2009 18:06:21 -0400
Received: from 91-114-244-100.adsl.highway.telekom.at (HELO [192.168.0.102]) ([91.114.244.100])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub95.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 30 Oct 2009 22:06:24 -0000
In-Reply-To: <4AEA2C54.9040502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> On 10/29/2009 02:41 PM, Peter Klotz wrote:
>> I have an eSATA box (2 HDDs) that when operated in BIG mode shows lots
>> of errors during startup.
>>
>> Both HDDs are started then stopped and started again.
>>
>> When first starting up the system reports a size of 7.99 GiB, finally
>> the correct value of 2.72 TiB is displayed.
>>
>> Can I trust a system showing the errors below?
> 
> I suspect this is one of those funky Silicon Image RAID PMP things that 
> has the fake "Config Disk" that shows up to allow configuring the RAID 
> array, and then presumably it then goes offline and then the actual RAID 
> array device shows up..

Yes, it is a Silicon Image (Sil5744) box.

Thanks for this explanation.

Now I am stuck with this box.

BIG mode shows these errors and I will not trust a system showing that 
many errors on startup.

JBOD mode shows no errors but requires PMP to see both HDDs which my 
SATA controller does not support. Maybe I can find an eSATA Express Card 
with PMP support that works in Linux.

Regards, Peter.
