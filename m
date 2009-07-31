From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Fri, 31 Jul 2009 20:07:16 GMT
Message-ID: <200907312007.n6VK7GMa003089@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:59868 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbZGaUHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Jul 2009 16:07:16 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n6VK7G3K003090
	for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2009 20:07:16 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882





--- Comment #13 from Robert Hancock <hancockrwd@gmail.com>  2009-07-31 20:07:16 ---
Presumably it's hitting this case:

    pci_read_config_dword(pdev, 0x50, &ata66);
    /* Check both the drive cable reporting bits, we might not have
       two drives */
    if (ata66 & (0x10100000 >> (16 * ap->port_no)))
        return ATA_CBL_PATA80;

The value at 0x50 is F1F1F6F2, which according to this logic means that an
80-wire cable is detected on all 4 drives. Hmm..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
