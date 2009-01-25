From: Tejun Heo <tj@kernel.org>
Subject: Re: Another libata error related to OCZ SSD
Date: Sun, 25 Jan 2009 10:00:43 +0900
Message-ID: <497BB9BB.4040608@kernel.org>
References: <20090111174159.GC4250@ics.muni.cz> <200901192239.25071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55942 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004AbZAYBBW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jan 2009 20:01:22 -0500
In-Reply-To: <200901192239.25071.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
> (CCing ACPI and IDE).
> 
> On Sunday 11 January 2009, Lukas Hejtmanek wrote:
>> Hello,
>>
>> I encountered another problem with the OCZ SSD disk. If I suspend to ram while
>> running from batteries, my disk disappears. I had no problem with suspends on
>> AC power.
>>
>> I created a screenshot of dmesg mesages:
>> http://www.fi.muni.cz/~xhejtman/IMG_3221.JPG

Does the following command make any difference?

 echo 0 > /sys/class/scsi_disk/h:c:i:l/manage_start_stop

The h:c:i:l part needs to be adjusted to point to the OCZ disk.  lscsi
will show which value to use.

Thanks.

-- 
tejun
