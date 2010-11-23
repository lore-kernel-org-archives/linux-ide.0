From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 23602] New: Pata Controller on Asrock X58 Extreme 6 not
 detected
Date: Tue, 23 Nov 2010 07:40:49 GMT
Message-ID: <bug-23602-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:44447 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab0KWHku (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Nov 2010 02:40:50 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id oAN7enrd027541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 23 Nov 2010 07:40:49 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=23602

               URL: https://bugzilla.novell.com/show_bug.cgi?id=649997
           Summary: Pata Controller on Asrock X58 Extreme 6 not detected
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.34.4
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: dfsusenet@yahoo.de
        Regression: No


The X58 pata controller on Asrock boards is not detected.

Bug has been reported on

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/649182
https://bugzilla.novell.com/show_bug.cgi?id=649997
full information is provided there, seems there is no upstream support.

lspci:
.....
03:00.1 IDE interface: VIA Technologies, Inc. PATA IDE Host Controller (rev a0)
(prog-if 85 [Master SecO PriO])
    Subsystem: ASRock Incorporation Device 0415
    Flags: fast devsel, IRQ 17
    I/O ports at dc00 [size=8]
    I/O ports at d880 [size=4]
    I/O ports at d800 [size=8]
    I/O ports at d480 [size=4]
    I/O ports at d400 [size=16]
    Expansion ROM at f3ff0000 [disabled] [size=64K]
    Capabilities: [50] Power Management version 3
    Capabilities: [70] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/0
Enable-
    Capabilities: [90] Express Legacy Endpoint, MSI 00
    Capabilities: [100] Advanced Error Reporting <?>
    Capabilities: [130] Device Serial Number 00-8f-13-ff-ff-39-06-00
.....

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
