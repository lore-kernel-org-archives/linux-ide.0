From: Jim Paris <jim@jtan.com>
Subject: Debian shutdown fixes
Date: Mon, 24 Dec 2007 00:43:00 -0500
Message-ID: <20071224054259.GA7793@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:53728 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbXLXF7M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Dec 2007 00:59:12 -0500
Received: from neurosis.jim.sh (localhost [127.0.0.1])
	by neurosis.jim.sh (8.14.1/8.14.1/Debian-9) with ESMTP id lBO5h0QC007916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Mon, 24 Dec 2007 00:43:00 -0500
Received: (from jim@localhost)
	by neurosis.jim.sh (8.14.1/8.14.1/Submit) id lBO5h077007915
	for linux-ide@vger.kernel.org; Mon, 24 Dec 2007 00:43:00 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

FYI:
I haven't tested it, but I notice a new version of the sysvinit
package was uploaded to Debian that should fix the libata shutdown
issues:

  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=426224#76

-jim
