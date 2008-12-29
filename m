From: Peter Klotz <peter.klotz@aon.at>
Subject: Re: PIONEER DVD-RW DVRTD08 is disabled if there is no disc present
 at   boot time
Date: Mon, 29 Dec 2008 23:11:07 +0100
Message-ID: <49594AFB.9030703@aon.at>
References: <1229894315.6931.17.camel@Thutmosis> <494EDDBE.3010306@shaw.ca>	 <494F65C1.80602@kernel.org> <1229947998.6045.10.camel@Thutmosis>	 <49505500.8080409@kernel.org> <1230126055.6430.17.camel@Thutmosis> <495886E7.7050204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from warsl404pip4.highway.telekom.at ([195.3.96.117]:5822 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753454AbYL2WLM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 17:11:12 -0500
Received: from 91-114-254-251.adsl.highway.telekom.at (HELO [192.168.0.100]) ([91.114.254.251])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub92.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 29 Dec 2008 22:11:08 -0000
In-Reply-To: <495886E7.7050204@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo wrote:
>> * and the error log when a CD can't be read looks like this (dmesg tail)
>> [  227.213893] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
>> driverbyte=DRIVER_SENSE,SUGGEST_OK
>> [  227.213914] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
>> [  227.213926] Info fld=0x2e81
>> [  227.213930] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
>> [  227.213942] end_request: I/O error, dev sr0, sector 47616
>> [  227.213954] Buffer I/O error on device sr0, logical block 5952
>> [  234.227424] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
>> driverbyte=DRIVER_SENSE,SUGGEST_OK
>> [  234.227446] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
>> [  234.227457] Info fld=0x2e81
>> [  234.227461] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
>> [  234.227473] end_request: I/O error, dev sr0, sector 47616
>> [  234.227484] Buffer I/O error on device sr0, logical block 5952
>> [  241.163142] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
>> driverbyte=DRIVER_SENSE,SUGGEST_OK
> ...
> 
> Those errors shouldn't have much to do with how the transport is
> configured.  These are the drive failing to read the media and these
> errors can be quite indetermininstic, so it's possible that the
> pattern really isn't a pattern but then again the drive doesn't seem
> to have much problem being peculiar.  Can you please test more times
> and verify the pattern?
> 

These errors remind me of this Ubuntu 8.10 bug:

https://bugs.launchpad.net/ubuntu/+bug/295795

This bug only shows up on discs burnt with Brasero, never on discs burnt 
with K3b.

Regards, Peter.
