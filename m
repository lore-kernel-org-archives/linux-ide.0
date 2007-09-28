From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: ICH9 2 port SATA controller port map?
Date: Fri, 28 Sep 2007 16:57:08 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701CF2D29@orsmsx420.amr.corp.intel.com>
References: <39B20DF628532344BC7A2692CB6AEE0701CC0C09@orsmsx420.amr.corp.intel.com> <46FB0273.60302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35082 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060AbXI1X5J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 19:57:09 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46FB0273.60302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

>-----Original Message-----
>From: Tejun Heo [mailto:htejun@gmail.com]
>Sent: Wednesday, September 26, 2007 6:08 PM
>To: Gaston, Jason D
>Cc: linux-ide@vger.kernel.org
>Subject: Re: ICH9 2 port SATA controller port map?
>
>Gaston, Jason D wrote:
>> Hello,
>>
>> ICH9 has DeviceID's for 2 port, IDE mode, SATA controllers.  The
current
>> port map in ata_piix is setup for the 4 port controllers.  This seems
to
>> work ok, but I wonder if a new port map should be defined for the 2
port
>> controllers, where the two ports are PM, SM?  You can refer to the
ICH9
>> Datasheet on intel.com for detail.
>
>Yes, please go ahead and define new entry for the controllers.  Thanks.
>
>--
>Tejun

What is the difference between NA and RV?  If the controller only has
access to 2 ports, does it matter which I set the nonexistent port
values to in the map?

Thanks,

Jason
