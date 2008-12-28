From: Peter Klotz <peter.klotz@aon.at>
Subject: Re: 2.6.28: Timeout problem with AHCI SATA DVD drive
Date: Sun, 28 Dec 2008 08:00:54 +0100
Message-ID: <49572426.1070801@aon.at>
References: <4955F0F9.1030700@aon.at> <49567DFF.4000102@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from WARSL404PIP3.highway.telekom.at ([195.3.96.115]:5655 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751305AbYL1HA6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Dec 2008 02:00:58 -0500
Received: from 212-183-96-186.adsl.highway.telekom.at (HELO [192.168.0.100]) ([212.183.96.186])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub92.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 28 Dec 2008 07:00:55 -0000
In-Reply-To: <49567DFF.4000102@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Robert Hancock wrote:
> OK, so it's a "test unit ready" command that got sent to the drive and 
> it timed out, then the resets after that all failed. That's essentially 
> the simplest command there is, so it seems likely that the drive went 
> off into the weeds and stopped talking to us. Whether or not we can do 
> anything to prevent it, I'm not sure.
> 
> You're sure the drive always detects that same disc properly in Windows?

You are right. I finally was able to reproduce this behavior in Windows. 
  The event log filled up with errors while the disc kept spinning.

So this may be a drive firmware issue?

Regards, Peter.
