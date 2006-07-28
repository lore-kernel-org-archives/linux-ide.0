From: Roman Medina-Heigl Hernandez <roman@rs-labs.com>
Subject: Possible fake host protected area (hpa) detected in ide drive causing
 SectorIdNotFound
Date: Fri, 28 Jul 2006 05:38:35 +0200
Message-ID: <44C986BB.3030006@rs-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta.hosting-seguridad.com ([207.150.162.14]:1453 "EHLO
	mta.hosting-seguridad.com") by vger.kernel.org with ESMTP
	id S1751796AbWG1Dip (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jul 2006 23:38:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mta.hosting-seguridad.com (Postfix) with ESMTP id 0973C602A6
	for <linux-ide@vger.kernel.org>; Fri, 28 Jul 2006 05:38:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mta.hosting-seguridad.com (Postfix) with ESMTP id CBE7060270
	for <linux-ide@vger.kernel.org>; Fri, 28 Jul 2006 05:38:44 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Please, read full description of the bug at:
https://launchpad.net/bugs/26119

(fully reproducible -at least- with ST340823A disks)

The bug tracker is Ubuntu's but I had the same problem with Fedora.

-- 

Saludos,
-Roman

PGP Fingerprint:
09BB EFCD 21ED 4E79 25FB  29E1 E47F 8A7D EAD5 6742
[Key ID: 0xEAD56742. Available at KeyServ]
