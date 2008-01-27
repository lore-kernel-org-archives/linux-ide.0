From: "dusty@gmx.li" <dusty@gmx.li>
Subject: Re: libata pm
Date: Sun, 27 Jan 2008 01:38:46 -0000 (UTC)
Message-ID: <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>
    <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>
    <479BC34D.2000007@gmail.com>
Reply-To: dusty@gmx.li
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavemail.org ([62.75.189.85]:34917 "EHLO mail.cavemail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbYA0Biv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 20:38:51 -0500
In-Reply-To: <479BC34D.2000007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: dusty@gmx.li, linux-ide@vger.kernel.org

Am Sa, 26.01.2008, 23:33, schrieb Tejun Heo:
> dusty@gmx.li wrote:
>> I could solve the problem by ncq blacklisting the "Maxtor 6V300F0"
>> devices in libata-core.c
>
> That's a strange story.  The reported error was PHY readiness changed
> and Device exchanged, both of which point to hotplug event.  Maybe
> something causes the firmware to reset?  What happen if you only leave two
> drives on the port multiplier and remove the NCQ blacklist?  Also, does
> the error ever occur on the drives which are connected directly to the
> controller?
>
>
> --
> tejun
>
>

No the error only occures on the drives on the pm. I can test the pm with
two Maxtor drives tomorrow (currently backing up the raid).



