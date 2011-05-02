From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 33402] [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
Date: Mon, 2 May 2011 19:14:54 GMT
Message-ID: <201105021914.p42JEsJQ004801@demeter2.kernel.org>
References: <bug-33402-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:35348 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab1EBTOz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2011 15:14:55 -0400
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id p42JEsTp004802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 2 May 2011 19:14:54 GMT
In-Reply-To: <bug-33402-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=33402





--- Comment #1 from Rafael J. Wysocki <rjw@sisk.pl>  2011-05-02 19:14:53 ---
On Monday, May 02, 2011, Mikael Pettersson wrote:
> On Sat, 30 Apr 2011 21:46:55 +0200 (CEST), "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > The following bug entry is on the current list of known regressions
> > from 2.6.38.  Please verify if it still should be listed and let the tracking team
> > know (either way).
> > 
> > 
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=33402
> > Subject		: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
> > Submitter	: Mikael Pettersson <mikpe@it.uu.se>
> > Date		: 2011-04-12 17:30 (19 days old)
> 
> Fixed in 2.6.39-rc5.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.