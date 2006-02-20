From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: sg corner case fixes against Linus tree
Date: Mon, 20 Feb 2006 23:48:37 +0900
Message-ID: <11404469172074-git-send-email-htejun@gmail.com>
References: <43F9970F.9010903@pobox.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:49547 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030261AbWBTOsj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 09:48:39 -0500
Received: by pproxy.gmail.com with SMTP id d42so1123322pyd
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 06:48:39 -0800 (PST)
In-Reply-To: <43F9970F.9010903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hello, Jeff.

This is the three sg corner case fix patches[1] regenerated against the
current Linus #master[2].  The assert()->WARN_ON() patch in libata-dev
#upstream will collide with this one.  It should be easy to resolve
though.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/8090
    http://article.gmane.org/gmane.linux.ide/8091
    http://article.gmane.org/gmane.linux.ide/8092
[2] bd71c2b17468a2531fb4c81ec1d73520845e97e1

