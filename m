From: Ryan Bourgeois <rgb005@latech.edu>
Subject: Hardware SATA RAID and Hotplug
Date: Tue, 27 Jul 2004 23:23:16 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41072A34.5040401@latech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from selene.LaTech.edu ([138.47.18.25]:38628 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S266304AbUG1EXP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2004 00:23:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by LaTech.edu (Postfix) with ESMTP id 663DD30AF70
	for <linux-ide@vger.kernel.org>; Tue, 27 Jul 2004 23:23:14 -0500 (CDT)
Received: from LaTech.edu ([127.0.0.1])
 by localhost (selene.latech.edu [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 83788-01-58 for <linux-ide@vger.kernel.org>;
 Tue, 27 Jul 2004 23:23:10 -0500 (CDT)
Received: from [10.20.10.1] (cable-24-196-221-182.opl.la.charter.com [24.196.221.182])
	by LaTech.edu (Postfix) with ESMTP id 624983095AB
	for <linux-ide@vger.kernel.org>; Tue, 27 Jul 2004 23:23:09 -0500 (CDT)
List-Id: linux-ide@vger.kernel.org
To: Linux IDE Mailing List <linux-ide@vger.kernel.org>

Ahh, yes, here it is...  I'm currently running the Promise S150 SX4 
controller, which is a 4-port SATA RAID 5 controller (Jeff, you know all 
about it I'm sure >8).  Anywho, I know further support is planned for 
the SX4, but as pointed out, hotplug support is not planned.  Which 
brings me to my two questions:  Why not?  And also: What accelerated 
RAID 5 SATA card could I expect to see with hotplug support?

Anywho, I've been keeping an eye on the IDE list for updates, and must 
say libata is looking great otherwise  >8)

-the other ryan

