From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: Sata 4726 Testing
Date: Thu, 10 Jan 2008 08:24:35 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07022FAA14@orsmsx420.amr.corp.intel.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com> <47850894.6090403@shaw.ca> <47856C6E.7090200@gmail.com> <39B20DF628532344BC7A2692CB6AEE07022FA8D0@orsmsx420.amr.corp.intel.com> <47858EBF.7050300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51221 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756182AbYAJQ03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 11:26:29 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47858EBF.7050300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Ryder <tireman@shaw.ca>, linux-ide@vger.kernel.org

>-----Original Message-----
>From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>owner@vger.kernel.org] On Behalf Of Tejun Heo
>Sent: Wednesday, January 09, 2008 7:19 PM
>To: Gaston, Jason D
>Cc: Andrew Ryder; linux-ide@vger.kernel.org
>Subject: Re: Sata 4726 Testing
>
>Gaston, Jason D wrote:
>> Attached are two dmesg outputs from 2.6.24-rc7 with only this simg
quirk
>> patch applied.
>>
>> The first (dmesg_wSipatch) was generated with the PMP turned off
during
>> boot and then powered on, while connected to eSATA.
>>
>> The second (dmesg_poweronoff) was generated with the PMP turned on
and
>> connected to eSATA during boot.  Then I turned the PMP off, let the
>> drives disappear from /sys/block/ and then turned on the PMP and let
the
>> drives reappear in /sys/block/.
>>
>> Please let me know if there is something else I can do.
>
>Thanks for testing.  It seems the errors you're seeing occur while the
>drives are initializing.  I'll look into that more but with or without
>the patch, all the devices are detected and usable, right?
>
>On 3726, the quirk patch has an unfortunate side effect of causing the
>first DMA commands to timeout.  I'll go and test 4726.
>
>Thanks.
>
>--
>tejun

Correct, with or without the patch, the drives are detected and usable.

Thanks,

Jason

