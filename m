From: "Don Dupuis" <dondster@gmail.com>
Subject: Libata and Drive Write Cache Disable
Date: Mon, 6 Nov 2006 11:48:41 -0600
Message-ID: <632b79000611060948v267bd33ahf1ff585cf4de9fcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:1831 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753600AbWKFRsn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Nov 2006 12:48:43 -0500
Received: by ug-out-1314.google.com with SMTP id m3so953883ugc
        for <linux-ide@vger.kernel.org>; Mon, 06 Nov 2006 09:48:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

When will this be supported in libata. I have drives attached to a
AHCI controller and want to turn drive write cache OFF. Sdparm will
not allow me to do so. Any work-arounds or patches would be greatly
appreciated. I am also using kernel 2.6.18.

Thanks

Don
