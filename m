From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA PMP support in 2.6.24-rc3?
Date: Thu, 10 Jan 2008 09:42:05 +0900
Message-ID: <478569DD.1080701@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com> <474CC423.70705@gmail.com> <474E2F5E.1010509@23palmer.net> <47836C36.4040701@gmail.com> <39B20DF628532344BC7A2692CB6AEE07022BC62E@orsmsx420.amr.corp.intel.com> <47845CB9.7040609@gmail.com> <39B20DF628532344BC7A2692CB6AEE07022FA70F@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.181]:22582 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbYAJAmQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 19:42:16 -0500
Received: by ro-out-1112.google.com with SMTP id p4so535577roc.5
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 16:42:11 -0800 (PST)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07022FA70F@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Tom Evans <tom@23palmer.net>, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> I am using a Sans Digital PMP, which has a Sil3726CBHU controller in it.
> I also have an Addonics PMP and it has the same controller in it.

Hmmm... I wonder why all SIMG PMPs I have work just fine.  :-(

Anyways, can you please test the patch I posted on the other thread on
both PMPs?

Thanks.

-- 
tejun
