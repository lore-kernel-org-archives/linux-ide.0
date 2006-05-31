From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH v2] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Wed, 31 May 2006 19:11:47 +0900
Message-ID: <447D6BE3.4020409@gmail.com>
References: <1148980614.3466.52.camel@forrest26.sh.intel.com> <447D6B49.5020103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:19382 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964947AbWEaKLw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 06:11:52 -0400
Received: by wr-out-0506.google.com with SMTP id 37so208067wra
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 03:11:52 -0700 (PDT)
In-Reply-To: <447D6B49.5020103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, liml@rtr.ca, ric@emc.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>> +	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
>> +	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
>> +		qc->ap->eh_info.action = ATA_EH_REVALIDATE;
> 
> Please do action |= ATA_EH_REVALIDATE.  Also, above schedules
> revalidation for both devices for a PATA port.  Currently, there is no
> way to specify which device is offending from qc completion path.  I'll
> submit a patch to allow it.  After the patch, please add
> qc->ap->eh_info.dev = qc->dev such that only the affected device is
> revalidated.

Please forget about the qc->ap->eh_info.dev = qc->dev stuff.  At the
second thought, it doesn't seem worth the trouble and seems safer as it
currently is.

-- 
tejun
