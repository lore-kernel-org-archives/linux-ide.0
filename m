From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata pm
Date: Sun, 27 Jan 2008 08:33:33 +0900
Message-ID: <479BC34D.2000007@gmail.com>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org> <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:20138 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbYAZXdj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jan 2008 18:33:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1222610rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 26 Jan 2008 15:33:39 -0800 (PST)
In-Reply-To: <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dusty@gmx.li
Cc: linux-ide@vger.kernel.org

dusty@gmx.li wrote:
> I could solve the problem by ncq blacklisting the "Maxtor 6V300F0" devices
> in libata-core.c

That's a strange story.  The reported error was PHY readiness changed
and Device exchanged, both of which point to hotplug event.  Maybe
something causes the firmware to reset?  What happen if you only leave
two drives on the port multiplier and remove the NCQ blacklist?  Also,
does the error ever occur on the drives which are connected directly to
the controller?


-- 
tejun
