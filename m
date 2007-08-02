From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Libata Sil3124 hybrid drive failure
Date: Thu, 2 Aug 2007 11:52:01 -0600
Message-ID: <8202f4270708021052y166eddb9mbb8c46e63308b8dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:45979 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896AbXHBRwD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 13:52:03 -0400
Received: by nf-out-0910.google.com with SMTP id g13so156525nfb
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 10:52:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi,

Does anyone know if libata supports hybrid drive on Sil3124? I tried
to play with Seagate hybrid drive and got protocol mismatch error when
adding LBAs to pinned set or querying pinned set?  Sil24 driver code
does not set Protocol Override field in PRB, just wonder if we need to
set protocol explicitly to get this work because the controller may
not decode the protocol correctly for nv cache commands.

Thanks,
Fajun
