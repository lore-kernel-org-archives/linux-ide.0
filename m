From: Peter Klotz <peter.klotz@aon.at>
Subject: Re: Does ICH9M support eSATA Port Multiplier?
Date: Fri, 30 Oct 2009 23:10:32 +0100
Message-ID: <4AEB6458.20401@aon.at>
References: <4AE9EEA3.1040404@aon.at> <4AEA2D16.50701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from WARSL404PIP3.highway.telekom.at ([195.3.96.115]:40561 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932958AbZJ3WKa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Oct 2009 18:10:30 -0400
Received: from 91-114-244-100.adsl.highway.telekom.at (HELO [192.168.0.102]) ([91.114.244.100])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub93.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 30 Oct 2009 22:10:33 -0000
In-Reply-To: <4AEA2D16.50701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
>> Can I enable it somehow maybe by using a module option?
> 
> No module parameter for that, you'd have to hack the code in ahci.c to 
> force the option on. No guarantees it's going to work if the controller 
> doesn't report the capability, though.

Could you please give me a hint what to change in ahci.c?

I would like to try and see what happens.

Could such a hack damage the hardware?

Regards, Peter.
