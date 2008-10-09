From: Ele <ele1@gmx.ch>
Subject: http://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perform_frequent_head_unloads_under_Linux
Date: Thu, 09 Oct 2008 17:24:21 +0200
Message-ID: <48EE2225.4050006@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37357 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752945AbYJIPYd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Oct 2008 11:24:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

Please add to your wiki page for WD green drives:
"workaround: Requires vendor specific tool wdidle3.exe to change the 
configuration.
The tool can only be obtained via WD support*, _but_ in some cases 
calling it with  paramter /D does not disable automatic unloads.*"

