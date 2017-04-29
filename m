From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: SATA: Fine-tuning for two function implementations
Date: Sat, 29 Apr 2017 10:30:29 +0200
Message-ID: <b2a3953b-8e8f-fea1-8a04-9ecafdf31102@users.sourceforge.net>
References: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
 <20170428215334.GH22354@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170428215334.GH22354@htj.duckdns.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> Hmmm, allocs -> callocs.  Are these actually beneficial?  If so, why?
> Because one multiplication is rolled into the call?

Did the previous size calculations contain the general possibility for
integer overflows?
https://cwe.mitre.org/data/definitions/190.html

* Will the computed values usually stay within the limits of the used
  data types so far?

* How much do you care for corresponding checks and source code annotations
  by functions like “devm_kcalloc”?

Regards,
Markus
