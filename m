From: Tim Small <tim@seoss.co.uk>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Thu, 08 Jan 2015 15:58:02 +0000
Message-ID: <54AEA90A.2020502@seoss.co.uk>
References: <20150107152648.GC4395@htj.dyndns.org> <1420727311-7066-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1420727311-7066-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 08/01/15 14:28, Martin K. Petersen wrote:


> +	{ "Micron_M[56]*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },


A minor quibble - but all the other HORKAGE flags are used to identify
things which are broken or non-functional about a device (and this is
implicit with the use of the word 'horkage' IMO).

However, this proposed flag is trying to imply behaviour which is an
"extra feature" (beyond the requirements of the spec).  So the intention
is to whitelist using a mechanism which is otherwise used only been used
to blacklist.

I know it's difficult coming up with something which isn't too
wordy/verbose, but IMO any of:

ATA_HORKAGE_TRIM_ALWAYS_ZEROS

ATA_TRIM_ALWAYS_ZEROS

ATA_RELIABLE_ZERO_AFTER_TRIM


would seem clearer to me, because as the patch currently stands,
"ATA_HORKAGE_ZERO_AFTER_TRIM" implies to me "zero after trim is broken
on this device".

Particularly with the Micron excerpt quoted above I initially parsed
this as "don't issue tagged TRIM commands to this device, and don't
assume it'll read zeros after TRIM either".


Tim.
