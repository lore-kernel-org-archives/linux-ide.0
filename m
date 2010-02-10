From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13770] System freeze on XFS filesystem recovery on an external
 disk
Date: Wed, 10 Feb 2010 09:22:37 GMT
Message-ID: <201002100922.o1A9Mbo8029727@demeter.kernel.org>
References: <bug-13770-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54367 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab0BJJWk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Feb 2010 04:22:40 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o1A9Mb8F029729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 10 Feb 2010 09:22:37 GMT
In-Reply-To: <bug-13770-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13770


Christoph Hellwig <hch@lst.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|XFS                         |IDE
         AssignedTo|hch@lst.de                  |io_ide@kernel-bugs.osdl.org
            Product|File System                 |IO/Storage




-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
