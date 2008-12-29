From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.28: Timeout problem with AHCI SATA DVD drive
Date: Mon, 29 Dec 2008 17:56:29 +0900
Message-ID: <495890BD.9070504@kernel.org>
References: <4955F0F9.1030700@aon.at> <49567DFF.4000102@shaw.ca> <49572426.1070801@aon.at> <4957F97B.2050002@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50875 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbYL2I4h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 03:56:37 -0500
In-Reply-To: <4957F97B.2050002@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> Peter Klotz wrote:
>> Robert Hancock wrote:
>>> OK, so it's a "test unit ready" command that got sent to the drive
>>> and it timed out, then the resets after that all failed. That's
>>> essentially the simplest command there is, so it seems likely that
>>> the drive went off into the weeds and stopped talking to us. Whether
>>> or not we can do anything to prevent it, I'm not sure.
>>>
>>> You're sure the drive always detects that same disc properly in Windows?
>>
>> You are right. I finally was able to reproduce this behavior in
>> Windows.  The event log filled up with errors while the disc kept
>> spinning.
>>
>> So this may be a drive firmware issue?
> 
> Almost certainly - you could see if there's a firmware update available..

If there's difference in frequency of it happening, it could be due to
the difference in which commands are used when polling for media
presence.  Windows only uses GET_EVENT_STATUS_NOTIFICATION while we
use a few more commands in combination including TUR.

If the drive actually is going nuts on TUR, disabling media polling
using hal-disable-polling might help.  If the drive just wanna check
out spontaneously, then, well...

-- 
tejun
