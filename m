From: "Saumendra Dash" <Saumendra.Dash@infogain.com>
Subject: RE: ULI 5288(SATA driver)
Date: Wed, 27 Feb 2008 16:35:22 +0530
Message-ID: <C86899CCB10A6C4E93D5978DCB232D4B07C86196@GDCMX01.igglobal.com>
References: <47C347F3.5070006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogain.com ([65.223.106.147]:9202 "EHLO
	ex2003test.igglobal.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752453AbYB0LVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 06:21:40 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47C347F3.5070006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


 Hi Jeff,
>> 
>>  I'm working on ULI1575 SATA driver which I want to run in Emulated-PATA 
>> mode.
>>  I have the following understanding to run a SATA device in 
> Emulated-PATA mode:
>> 
>>   1. In Emulated-PATA mode the legacy IDE driver should access the SATA 
>> device directly in combined mode.
>>   2. The class code of the device shlould be set to Emulated-PATA 
>> mode(0x0185).
>>   3. Enable SATA in combine mode. 
>> 
>>  After doing the above changes the driver does not work in Emulated-PATA 
>> mode.
>> 
>>  Is there something missing to make the driver work in Emulated-PATA mode?

>Use a PCI quirk to unconditionally disable emulated PATA mode, because 
>it's not needed.

 I have disabled the emulated PATA mode this time but the following error is comming in both the ocassion.
 When I'm creating the partition using mkpart it is showing "The bus is in an invalid state, Access of this device is not allowed." and ide_open() returns with "No such device".

 Please suggest me what could be the problem?

Thanks,
Saumendra





